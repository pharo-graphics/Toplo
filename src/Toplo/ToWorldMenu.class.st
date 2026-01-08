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
		iconName: #smallDebug;
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
		iconName: #go
]

{ #category : #'menu - toplo' }
ToWorldMenu class >> menuGithubOn: aBuilder [
	<worldMenu>

	(aBuilder item: #ToploGitHub)
		parent: #Toplo;
		order: 3;
		label: 'GitHub';
		help: 'Open Toplo GitHub page';
		iconName: #github;
		action: [ WebBrowser openOn: 'https://github.com/pharo-graphics/Toplo/' ]
]

{ #category : #'menu - toplo' }
ToWorldMenu class >> menuReportABugOn: aBuilder [
	<worldMenu>

	(aBuilder item: #ToploBugReport)
		parent: #Toplo;
		order: 2;
		label: 'Report a Bug';
		help: 'Will open the GitHub page to report an issue';
		iconName: #smallDebug;
		action: [ WebBrowser openOn: 'https://github.com/pharo-graphics/Toplo/issues/new' ]
]

{ #category : #menu }
ToWorldMenu class >> menuToploOn: aBuilder [
	<worldMenu>
	
	(aBuilder item: #Toplo) 
		parent: #Tools;
		order: 779;
		label: 'Toplo';
		help: 'A widget framework on top of Bloc';
		iconName: #smallWindow
]

{ #category : #'see class side' }
ToWorldMenu >> seeClassSide [
]
