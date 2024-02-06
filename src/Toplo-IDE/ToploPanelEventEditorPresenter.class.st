Class {
	#name : #ToploPanelEventEditorPresenter,
	#superclass : #ToploPanelPresenter,
	#instVars : [
		'eventListener',
		'whenListenerChangedDo',
		'theme'
	],
	#category : #'Toplo-IDE-theme-editor-deprecated'
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
ToploPanelEventEditorPresenter >> theme [

	^ theme
]

{ #category : #accessing }
ToploPanelEventEditorPresenter >> theme: aToTheme [
theme:= aToTheme

	
]

{ #category : #accessing }
ToploPanelEventEditorPresenter >> updatePresenter [

	| inside |
	inside := self eventListener
		          ifNil: [ SpNullPresenter new ]
		          ifNotNil: [
			          ToploPanelEventListenerEditor new
			theme: self theme;
				          eventListener: self eventListener;
				          whenListenerChangedDo: [ :newListener :oldListener |
					          self whenListenerChangedDo
						          value: newListener
						          value: oldListener ];
				          yourself ].
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
