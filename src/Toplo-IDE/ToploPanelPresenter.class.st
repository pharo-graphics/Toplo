Class {
	#name : #ToploPanelPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'panelContent'
	],
	#category : #'Toplo-IDE-theme-editor-deprecated'
}

{ #category : #layout }
ToploPanelPresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		  spacing: 4;
		  add: (SpLabelPresenter new
				   displayBold: [ :t | true ];
				   label: self panelName;
				   yourself)
		  expand: false;
		  add: self panelContent expand: true;
		  yourself
]

{ #category : #initialization }
ToploPanelPresenter >> initializePresenters [

	panelContent := SpNullPresenter new.
]

{ #category : #'as yet unclassified' }
ToploPanelPresenter >> panelContent [

	^ panelContent
]

{ #category : #'as yet unclassified' }
ToploPanelPresenter >> panelName [

	^ self shouldBeImplemented
]

{ #category : #accessing }
ToploPanelPresenter >> theme: aToTheme [

	self shouldBeImplemented
]
