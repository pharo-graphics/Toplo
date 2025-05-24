Class {
	#name : #ToWorldMenu,
	#superclass : #Object,
	#category : #'Toplo-Core'
}

{ #category : #'menu - toplo' }
ToWorldMenu class >> menuCleanUpUniverseOn: aBuilder [

	<worldMenu>
	(aBuilder item: #CleanupUniverse)
		parent: #Toplo;
		order: 10;
		label: 'Cleanup Universe';
		help: 'Close all spaces then restart the underlying host';
		icon: (self iconNamed: #smallDebug);
		action: [ Toplo closeAllSpaces ]
]

{ #category : #'menu - toplo' }
ToWorldMenu class >> menuExamples: aBuilder [
	<worldMenu>
	(aBuilder item: #ToploExamples)
		parent: #Toplo;
		order: 1;
		label: 'Examples';
		help: 'Show Toplo examples';
		icon: (self iconNamed: #glamorousGo)
]

{ #category : #'menu - toplo - examples' }
ToWorldMenu class >> menuExamplesLoginPage: aBuilder [
	<worldMenu>
	(aBuilder item: #ToploExamplesLoginPage)
		parent: #ToploExamples;
		order: 1;
		label: 'Login page';
		help: 'Open a login page';
		icon: (self iconNamed: #glamorousGo);
		action:[ ToExLoginPage open ].
]

{ #category : #'menu - toplo - examples' }
ToWorldMenu class >> menuExamplesSandBox: aBuilder [
	<worldMenu>
	(aBuilder item: #ToploExamplesSandBox)
		parent: #ToploExamples;
		order: 1;
		label: 'Sand box examples';
		help: 'Browse Toplo sand box examples';
		icon: (self iconNamed: #glamorousGo);
		action:[ ToSandBox class browse ].
]

{ #category : #'menu - toplo - examples' }
ToWorldMenu class >> menuExamplesSourceCodeBrowser: aBuilder [
	<worldMenu>
	(aBuilder item: #ToploExamplesMiniBrowser)
		parent: #ToploExamples;
		order: 1;
		label: 'Source code Browser';
		help: 'Open a source code mini browser';
		icon: (self iconNamed: #glamorousGo);
		action:[ ToExMiniBrowser open ].
]

{ #category : #'menu - toplo' }
ToWorldMenu class >> menuGithubOn: aBuilder [
	<worldMenu>
	(aBuilder item: #ToploGitHub)
		parent: #Toplo;
		order: 3;
		label: 'GitHub';
		help: 'Open Toplo GitHub page';
		icon: (self iconNamed: #github);
		action: [ WebBrowser openOn: 'https://github.com/plantec/Toplo/' ]
]

{ #category : #'menu - toplo' }
ToWorldMenu class >> menuReportABugOn: aBuilder [
	<worldMenu>
	(aBuilder item: #ToploBugReport)
		parent: #Toplo;
		order: 2;
		label: 'Report a Bug';
		icon: (self iconNamed: #smallDebug);
		help: 'Will open the GitHub page to report an issue';
		action: [ WebBrowser openOn: 'https://github.com/plantec/Toplo/issues/new' ]
]

{ #category : #menu }
ToWorldMenu class >> menuToploOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Toplo) 
		parent: #Tools;
		label: 'Toplo';
		icon: (self iconNamed: #smallWindow);
		help: 'A widget framework on top of Bloc';
		order: 777
]

{ #category : #'see class side' }
ToWorldMenu >> seeClassSide [
]
