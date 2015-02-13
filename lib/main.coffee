

module.exports =
  OpenLastProject: null
  Subscriptions: []
  activate:(state)->
    @OpenLastProject = require('./open-last-project')
    @OpenLastProject.LoadProject() unless atom.project.path
    @OpenLastProject.LoadFiles(state) if state.Status
  deactivate:->
    @Subscriptions.forEach (sub)-> sub.dispose()
    @Subscriptions = []
  serialize:->
    Files = []
    ActiveEditor = atom.workspace.getActiveEditor()
    atom.workspace.eachEditor (editor)->
      File = editor.getPath()
      return unless File
      Files.push File
    CurrentFile = ActiveEditor && ActiveEditor.getPath() || null;
    Status: true, Files: Files, CurrentFile: CurrentFile
