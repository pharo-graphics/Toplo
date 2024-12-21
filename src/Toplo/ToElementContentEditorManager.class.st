Class {
	#name : #ToElementContentEditorManager,
	#superclass : #ToAnchoredWindowManager,
	#instVars : [
		'editor'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToElementContentEditorManager >> currentEditorEventHandlers [

	^ Array streamContents: [ :stream |
		  element eventDispatcher handlersDo: [ :h |
			  (h isKindOf: ToElementEditorEvent)  ifTrue: [
				  stream nextPut: h ] ] ]
]

{ #category : #initializing }
ToElementContentEditorManager >> defaultPlacement [

	^ ToElementEditorPlacement new
]

{ #category : #accessing }
ToElementContentEditorManager >> editor [

	^ editor
]

{ #category : #accessing }
ToElementContentEditorManager >> editorClosedEventClass [ 

	^ ToElementEditorClosedEvent 
]

{ #category : #accessing }
ToElementContentEditorManager >> editorOpenedEventClass [ 

	^ ToElementEditorOpenedEvent 
]

{ #category : #'window handling' }
ToElementContentEditorManager >> onClosed [

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
ToElementContentEditorManager >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement onInstalledEditorManager: self
]

{ #category : #'window handling' }
ToElementContentEditorManager >> onOpened [

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
ToElementContentEditorManager >> onUninstalledIn: anElement [

	anElement onUninstalledEditorManager: self.
	super onInstalledIn: anElement.

]

{ #category : #enumerating }
ToElementContentEditorManager >> whenEditorClosedDo: aValuable [

	" aValuable takes the event as argument "
	^ element addEventHandlerOn: self editorClosedEventClass do: aValuable
]

{ #category : #enumerating }
ToElementContentEditorManager >> whenEditorOpenedDo: aValuable [

	" aValuable takes the event as argument "
	^ element addEventHandlerOn: self editorOpenedEventClass do: aValuable
]
