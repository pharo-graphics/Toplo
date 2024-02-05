Class {
	#name : #ToploPanelInsideEventEditorAbstract,
	#superclass : #SpPresenter,
	#instVars : [
		'eventListener'
	],
	#category : #'Toplo-IDE-theme-editor'
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
]
