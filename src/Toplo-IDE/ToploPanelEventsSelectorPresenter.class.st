Class {
	#name : #ToploPanelEventsSelectorPresenter,
	#superclass : #ToploPanelWithButtonPresenter,
	#category : #'Toplo-IDE-theme-editor'
}

{ #category : #initialization }
ToploPanelEventsSelectorPresenter >> initializePresenters [

	super initializePresenters.
	panelContent := SpTablePresenter new.
]

{ #category : #'as yet unclassified' }
ToploPanelEventsSelectorPresenter >> panelName [

	^ 'Events selection'
]

{ #category : #accessing }
ToploPanelEventsSelectorPresenter >> theme: aToTheme [
	"Do nothing"

	
]
