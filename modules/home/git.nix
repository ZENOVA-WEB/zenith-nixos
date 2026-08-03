{ vars, ... }: 

{ 
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = vars.fullName;
        email = vars.email;
      };
    };
  };
}