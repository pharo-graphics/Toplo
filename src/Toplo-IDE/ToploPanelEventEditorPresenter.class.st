Class {
	#name : #ToploPanelEventEditorPresenter,
	#superclass : #ToploPanelPresenter,
	#instVars : [
		'eventListener',
		'whenListenerChangedDo'
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
ToploPanelEventEditorPresenter >> initializePresenters [

	super initializePresenters.
	whenListenerChangedDo := [ :new :old |  ].
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
		          ifNil: [ SpNullPresenter new ]
		          ifNotNil: [
			          ToploPanelEventListenerEditor new
				          eventListener: self eventListener;
				          whenListenerChangedDo: [ :newListener :oldListener |
					          self whenListenerChangedDo
						          value: newListener
						          value: oldListener ] ;yourself ].
	self panelContent: inside.
	self layout: self defaultLayout
]

{ #category : #accessing }
ToploPanelEventEditorPresenter >> whenListenerChangedDo [

	^ whenListenerChangedDo
]

{ #category : #accessing }
ToploPanelEventEditorPresenter >> whenListenerChangedDo: anObject [

	whenListenerChangedDo := anObject
]
