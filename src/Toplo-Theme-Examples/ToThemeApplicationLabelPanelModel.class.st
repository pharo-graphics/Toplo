Class {
	#name : #ToThemeApplicationLabelPanelModel,
	#superclass : #ToThemeApplicationLineAndStampsPanelModel,
	#category : #'Toplo-Theme-Examples'
}

{ #category : #'as yet unclassified' }
ToThemeApplicationLabelPanelModel >> allStampsVariation [

	^ { nil . #primary . #H1 . #H2 . #H3 . #H4 . #h5 }
]

{ #category : #accessing }
ToThemeApplicationLabelPanelModel >> makeElements [

	| label1 label2 label3 label4 |
	label1 := (ToLabel id: #label1) text: 'Bloc'.
	label2 := (ToLabel id: #label2) text: 'is'.
	label3 := (ToLabel id: #label3) text: 'so'.
	label4 := (ToLabel id: #label4) text: 'Awesome !'.

	^ {
		  label1.
		  label2.
		  label3.
		  label4 }
]

{ #category : #accessing }
ToThemeApplicationLabelPanelModel >> name [

	^ 'Labels'
]
