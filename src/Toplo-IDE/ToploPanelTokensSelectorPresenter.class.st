Class {
	#name : #ToploPanelTokensSelectorPresenter,
	#superclass : #ToploPanelWithButtonPresenter,
	#category : #'Toplo-IDE-theme-editor'
}

{ #category : #initialization }
ToploPanelTokensSelectorPresenter >> initializePresenters [

	super initializePresenters.
	panelContent := SpTablePresenter new.
]

{ #category : #'as yet unclassified' }
ToploPanelTokensSelectorPresenter >> panelName [

	^ 'Tokens selection'
]

{ #category : #accessing }
ToploPanelTokensSelectorPresenter >> theme: aToTheme [

	self panelContent items: aToTheme class defaultTokenProperties
]
