# Makerble Medical Clinic

It's a web application built in rails 7 with Turbo and Stimulus, using as admin template [core-ui](https://coreui.io/bootstrap/docs/getting-started/introduction/) and [core-ui admin template](https://coreui.io/bootstrap/docs/templates/admin-dashboard/) and importmap as js package manager.

This application has the focus to be part of my personnal portfolio, but feel free to copy it or fork.

## Makerble challenge application

This project was built as part of the required assesment to apply to Makerble.

This application were built using the gems:
- Devise: for authentication
- Pundit: for authorization
- Pagy: for pagination
- dartsass-sprockets: for sass processing
- bootstrap: for css
- stimulus/turbo: for js

This application uses the standard MVC architecture and use PostgreSQL as the default database. The views are componsed by erb pages and the js controllers for real time updates. 

### How to use

#### Running on .devcontainers
In order to run this application is required the following setup:
    
- vsCode
- Docker
- Internet access
- Support to devcontainers

Open the solution on the root path and the press
    
     ctrl + shift + p 
A floating window will appears then just type "devcontainers: reopen in devcontainers" select the option then press enter.

Now the container will start to be built, it will take a while and please don't forget to type "yes" when asked by ``sorbet``. Otherwise the building process will take forever.

Once all the process finishes there is a small bug on the ```Ruby LSP``` which will not recognize the asdf as the default ruby manager. To fix it just go to the extension settings and look for ``Custom Ruby Command`` then type ``asdf`` on it.

Now the project should be okay to run.

#### Directly on your machine

It's required the tools:

- ruby 3.3.0
- Postgres
- Also setup those apps required for the [active storage](https://guides.rubyonrails.org/active_storage_overview.html)

Once the role setup where done you can be able to run the project.

### Running the project

To preload some data and apply the migrations you should run the command: 

    rails dev:setup

``dev:setup`` is a custom task where will create, migrate, seed and pre-populate the DB.


This task will create the three default users, they are:
- Admin Master
    - email: admin.master@acme.com
    - pass: 123456
- Doctor Default
    - email: doctor.default@acme.com
    - pass: 123456
- Operator Default
    - email: operator.default@acme.com
    - pass: 123456    

Each one of the users has a different permission level and can perform different tasks, as a example the operator default which can add new patients but the doctor not.

This users were created to easily test the application and check the different level of access between the roles.


### Issues

If there is any issue that need to be addressed, please fill free to open a ticket to discuss it.