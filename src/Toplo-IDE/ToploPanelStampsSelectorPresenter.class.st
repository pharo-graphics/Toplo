Class {
	#name : #ToploPanelStampsSelectorPresenter,
	#superclass : #ToploPanelPresenter,
	#category : #'Toplo-IDE-theme-editor'
}

{ #category : #initialization }
ToploPanelStampsSelectorPresenter >> initializePresenters [

	super initializePresenters.
	panelContent := SpTablePresenter new.
]

{ #category : #'as yet unclassified' }
ToploPanelStampsSelectorPresenter >> panelName [

	^ 'Stamps selection'
]

{ #category : #accessing }
ToploPanelStampsSelectorPresenter >> theme: aToTheme [

	self flag: #TODO.
	self panelContent items: {  }
]
