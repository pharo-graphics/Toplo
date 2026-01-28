Extension { #name : #ToWorldMenu }

{ #category : #'*Toplo-Examples' }
ToWorldMenu class >> menuExamplesLoginPage: aBuilder [
	<worldMenu>

	(aBuilder item: #ToploExamplesLoginPage)
		parent: #ToploExamples;
		order: 1;
		label: 'Login page';
		help: 'Open a login page';
		iconName: #go;
		action:[ ToExLoginPage open ]
]

{ #category : #'*Toplo-Examples' }
ToWorldMenu class >> menuExamplesSandBox: aBuilder [
	<worldMenu>

	(aBuilder item: #ToploExamplesSandBox)
		parent: #ToploExamples;
		order: 1;
		label: 'Sand box examples';
		help: 'Browse Toplo sand box examples';
		iconName: #go;
		action:[ ToSandBox class browse ]
]

{ #category : #'*Toplo-Examples' }
ToWorldMenu class >> menuExamplesSourceCodeBrowser: aBuilder [
	<worldMenu>

	(aBuilder item: #ToploExamplesMiniBrowser)
		parent: #ToploExamples;
		order: 1;
		label: 'Source code Browser';
		help: 'Open a source code mini browser';
		iconName: #go;
		action: [ ToExMiniBrowser open ]
]
