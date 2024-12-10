class LogMaintainView : LogViewService
{
    let logMaintainViewModel : LogViewModelService
    let loginDataLayer : LoginDataLayer = LoginDataLayer()
    init (logMaintainViewModel : LogViewModelService)
    {
        self.logMaintainViewModel = logMaintainViewModel
    }
    func displayLogDetails(logMaintain : [LogMaintain]) throws
    {
        if logMaintain.isEmpty
        {
            throw DatabaseError.noRecordFound(msg: "No Log Record Found")
        }
        for log in logMaintain
        {
            print(log)
            print("---------------------------------------------------------------")
        }
    }
}
