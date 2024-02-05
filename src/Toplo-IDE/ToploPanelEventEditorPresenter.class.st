Class {
	#name : #ToploPanelEventEditorPresenter,
	#superclass : #ToploPanelPresenter,
	#instVars : [
		'eventListener'
	],
	#category : #'Toplo-IDE-theme-editor'
}

{ #category : #accessing }
ToploPanelEventEditorPresenter >> eventListener [

	^ eventListener
]

{ #category : #accessing }
ToploPanelEventEditorPresenter >> eventListener: aLookEventListnerOrNil [ 
	eventListener := aLookEventListnerOrNil.
	self updatePresenter.
]

{ #category : #accessing }
ToploPanelEventEditorPresenter >> panelContent: aSpPresenter [

	panelContent:= aSpPresenter

]

{ #category : #'as yet unclassified' }
ToploPanelEventEditorPresenter >> panelName [

	^ 'Event editor'
]

{ #category : #accessing }
ToploPanelEventEditorPresenter >> theme: aToTheme [

	"Do nothing"
]

{ #category : #accessing }
ToploPanelEventEditorPresenter >> updatePresenter [

	| inside |
	inside := self eventListener
		          ifNil: [ ToploPanelInsideEventEditorForNil new ]
		          ifNotNil: [
			          self eventListener isAction
				          ifTrue: [ ToploPanelInsideEventEditorForAction new ]
				          ifFalse: [
				          ToploPanelInsideEventEditorForPropertyWriter new ] ].
	inside eventListener: self eventListener.
	self panelContent: inside.
	self layout: self defaultLayout
]
