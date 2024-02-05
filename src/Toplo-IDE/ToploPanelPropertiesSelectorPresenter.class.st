Class {
	#name : #ToploPanelPropertiesSelectorPresenter,
	#superclass : #ToploPanelWithButtonPresenter,
	#category : #'Toplo-IDE-theme-editor'
}

{ #category : #initialization }
ToploPanelPropertiesSelectorPresenter >> initializePresenters [

	super initializePresenters.
	panelContent := SpTablePresenter new.
]

{ #category : #'as yet unclassified' }
ToploPanelPropertiesSelectorPresenter >> panelName [

	^ 'Properties selection'
]

{ #category : #accessing }
ToploPanelPropertiesSelectorPresenter >> theme: aToTheme [

	self panelContent items: aToTheme styleSheet writablePropertyIndex allProperties
]
