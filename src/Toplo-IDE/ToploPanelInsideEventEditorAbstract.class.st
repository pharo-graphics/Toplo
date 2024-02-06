Class {
	#name : #ToploPanelInsideEventEditorAbstract,
	#superclass : #SpPresenter,
	#instVars : [
		'eventListener'
	],
	#category : #'Toplo-IDE-theme-editor-deprecated'
}

{ #category : #accessing }
ToploPanelInsideEventEditorAbstract >> eventListener [

	^ eventListener
]

{ #category : #accessing }
ToploPanelInsideEventEditorAbstract >> eventListener: anEventListener [

	eventListener := anEventListener.
	self updatePresenter
]

{ #category : #'as yet unclassified' }
ToploPanelInsideEventEditorAbstract >> makeNewListener [

	^ self shouldBeImplemented
]

{ #category : #accessing }
ToploPanelInsideEventEditorAbstract >> theme: aToTheme [

	"Do nothing"
]
