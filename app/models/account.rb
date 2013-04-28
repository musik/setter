class Account < WashOut::Type
  map :CmdCompanyID => :integer,
      :CmdCompanyUrl=> :string,
      :CmdUserID=>:string,
      :CmdUserName=>:string,
      :CmdUserPwd=>:string
end
