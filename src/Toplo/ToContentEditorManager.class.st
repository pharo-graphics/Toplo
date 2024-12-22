Class {
	#name : #ToContentEditorManager,
	#superclass : #ToAnchoredWindowManager,
	#instVars : [
		'editor'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToContentEditorManager >> currentEditorEventHandlers [

	^ Array streamContents: [ :stream |
		  element eventDispatcher handlersDo: [ :h |
			  (h isKindOf: ToElementEditorEvent)  ifTrue: [
				  stream nextPut: h ] ] ]
]

{ #category : #initializing }
ToContentEditorManager >> defaultPlacement [

	^ ToElementEditorPlacement new
]

{ #category : #accessing }
ToContentEditorManager >> editor [

	^ editor
]

{ #category : #accessing }
ToContentEditorManager >> editorClosedEventClass [ 

	^ ToElementEditorClosedEvent 
]

{ #category : #accessing }
ToContentEditorManager >> editorOpenedEventClass [ 

	^ ToElementEditorOpenedEvent 
]

{ #category : #'window handling' }
ToContentEditorManager >> onClosed [

	super onClosed.
	element dispatchEvent: (self editorClosedEventClass new
			 editorElement: editor;
			 yourself).

	element beforeEditorClosed: editor fromManager: self.
	self currentEditorEventHandlers do: [ :h |
		element removeEventHandler: h ].

	editor := nil
]

{ #category : #'api - hooks' }
ToContentEditorManager >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement onInstalledEditorManager: self
]

{ #category : #'window handling' }
ToContentEditorManager >> onOpened [

	super onOpened.

	editor := element newEditorForManager: self.

	element beforeEditorOpened: editor fromManager: self.

	currentWindow root addChild: editor.
	element enqueueTask: (BlTaskAction new action: [
			 element dispatchEvent: (self editorOpenedEventClass new
					  editorElement: editor;
					  yourself) ])
]

{ #category : #'api - hooks' }
ToContentEditorManager >> onUninstalledIn: anElement [

	anElement onUninstalledEditorManager: self.
	super onInstalledIn: anElement.

]

{ #category : #enumerating }
ToContentEditorManager >> whenEditorClosedDo: aValuable [

	" aValuable takes the event as argument "
	^ element addEventHandlerOn: self editorClosedEventClass do: aValuable
]

{ #category : #enumerating }
ToContentEditorManager >> whenEditorOpenedDo: aValuable [

	" aValuable takes the event as argument "
	^ element addEventHandlerOn: self editorOpenedEventClass do: aValuable
]
