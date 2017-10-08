fs = require('fs')
path = require('path')
{spawn, exec, spawnSync} = require('child_process')
_ = require('lodash')

runSync = (command, options, next) ->  # !TODO: Upgrade to runSync in node-localstorage
  {stderr, stdout} = runSyncRaw(command, options)
  if stderr?.length > 0
    console.error("Error running `#{command}`\n" + stderr)
    process.exit(1)
  if next?
    next(stdout)
  else
    if stdout?.length > 0
      console.log("Stdout running command '#{command}'...\n" + stdout)

runSyncNoExit = (command, options = []) ->
  {stderr, stdout} = runSyncRaw(command, options)
  console.log("Output of running '#{command + ' ' + options.join(' ')}'...\n#{stderr}\n#{stdout}\n")
  return {stderr, stdout}

runSyncRaw = (command, options) ->
  output = spawnSync(command, options)
  stdout = output.stdout?.toString()
  stderr = output.stderr?.toString()
  return {stderr, stdout}




# runAsync = (command, options, next) ->
#   if options? and options.length > 0
#     command += ' ' + options.join(' ')
#   exec(command, (error, stdout, stderr) ->
#     if stderr.length > 0
#       console.log("Stderr exec'ing command '#{command}'...\n" + stderr)
#     if error?
#       console.log('exec error: ' + error)
#     if next?
#       next(stdout)
#     else
#       if stdout.length > 0
#         console.log("Stdout exec'ing command '#{command}'...\n" + stdout)
#   )

task('doctest', 'Runs doctests found in documentation', () ->
  process.chdir(__dirname)
  fs.readdir('./', (err, contents) ->
    files = ("#{file}" for file in contents when (file.indexOf('.coffee') > 0))
    runSync('node_modules/coffeedoctest/bin/coffeedoctest', ['--readme'].concat(files))
  )
)

task('publish-old', 'Publish to npm', () ->
  process.chdir(__dirname)
  runSync('cake test')  # Doing this exernally to make it synchrous
  runSync('git status --porcelain', [], (stdout) ->
    if stdout.length == 0
      {stdout, stderr} = execSync('git rev-parse origin/master', true)
      stdoutOrigin = stdout
      {stdout, stderr} = execSync('git rev-parse master', true)
      stdoutMaster = stdout
      if stdoutOrigin == stdoutMaster
        console.log('running npm publish')
        {stdout, stderr} = execSync('npm publish .', true)
        if fs.existsSync('npm-debug.log')
          console.error('`npm publish` failed. See npm-debug.log for details.')
        else
          console.log('running git tag')
          runSync("git tag v#{require('./package.json').version}")
          runAsync("git push --tags")
      else
        console.error('Origin and master out of sync. Not publishing.')
    else
      console.error('`git status --porcelain` was not clean. Not publishing.')
  )
)

# task('publish', 'Publish to npm, add git tags', () ->
#   process.chdir(__dirname)
#   runSync('cake test')  # Doing this externally to make it synchrous
#   invoke('doctest')
#   process.chdir(__dirname)
#   console.log('checking git status --porcelain')
#   runSync('git status --porcelain', [], (stdout) ->
#     if stdout.length == 0
#
#       console.log('checking origin/master')
#       {stderr, stdout} = runSyncNoExit('git rev-parse origin/master')
#
#       console.log('checking master')
#       stdoutOrigin = stdout
#       {stderr, stdout} = runSyncNoExit('git rev-parse master')
#       stdoutMaster = stdout
#
#       if stdoutOrigin == stdoutMaster
#
#         console.log('running npm publish')
#         runSyncNoExit('coffee -c *.coffee')
#         runSyncNoExit('npm publish .')
#
#         if fs.existsSync('npm-debug.log')
#           console.error('`npm publish` failed. See npm-debug.log for details.')
#         else
#
#           console.log('creating git tag')
#           runSyncNoExit("git tag v#{require('./package.json').version}")
#           runSyncNoExit("git push --tags")
#       else
#         console.error('Origin and master out of sync. Not publishing.')
#     else
#       console.error('`git status --porcelain` was not clean. Not publishing.')
#   )
# )

task('publish', 'Publish to npm and add git tags', () ->
  process.chdir(__dirname)

  console.log('Running tests')
  runSync('cake', ['test'])  # Doing this externally to make it synchronous

  console.log('Checking git status --porcelain')
  runSync('git', ['status', '--porcelain'], (stdout) ->
    if stdout.length == 0

      console.log('checking origin/master')
      {stderr, stdout} = runSyncNoExit('git', ['rev-parse', 'origin/master'])
      console.log('checking master')
      stdoutOrigin = stdout
      {stderr, stdout} = runSyncNoExit('git', ['rev-parse', 'master'])
      stdoutMaster = stdout

      if stdoutOrigin == stdoutMaster

        console.log('running npm publish')
        runSyncNoExit('coffee -c *.coffee')
        runSyncNoExit('npm', ['publish', '.'])

        if fs.existsSync('npm-debug.log')
          console.error('`npm publish` failed. See npm-debug.log for details.')
        else

          console.log('creating git tag')
          runSyncNoExit("git", ["tag", "v#{require('./package.json').version}"])
          runSyncNoExit("git", ["push", "--tags"])

          console.log('removing .js and .map files')
          runSync('cake', ['clean'])

      else
        console.error('Origin and master out of sync. Not publishing.')
    else
      console.error('`git status --porcelain` was not clean. Not publishing.')
  )
)

task('test', 'Run the test suite with nodeunit', () ->
  require('coffee-script/register')
  {reporters} = require('nodeunit')
  process.chdir(__dirname)
  reporters.default.run(['test'], undefined, (failure) ->
    if failure?
      console.error(failure)
      process.exit(1)
  )
)

task('testall', 'Runs both tests and doctests', () ->
  invoke('test')
  invoke('doctest')
)

task('clean', 'Deletes .js and .map files', () ->
  folders = ['.', 'test']
  for folder in folders
    pathToClean = path.join(__dirname, folder)
    contents = fs.readdirSync(pathToClean)
    for file in contents when (_.endsWith(file, '.js') or _.endsWith(file, '.map'))
      fs.unlinkSync(path.join(pathToClean, file))
)
