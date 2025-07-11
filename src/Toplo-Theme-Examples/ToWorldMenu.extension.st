Extension { #name : #ToWorldMenu }

{ #category : #'*Toplo-Theme-Examples' }
ToWorldMenu class >> menuExamplesTheme: aBuilder [
	<worldMenu>

	(aBuilder item: #ToploExamplesTheme)
		parent: #ToploExamples;
		order: 1;
		label: 'Theme examples';
		help: 'Browse Toplo theme examples';
		iconName: #go;
		action:[ ToThemeExamples class browse ].
]
