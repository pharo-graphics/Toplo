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
		  anchorElement eventDispatcher handlersDo: [ :h |
			  (h isKindOf: ToElementEditorEvent)  ifTrue: [
				  stream nextPut: h ] ] ]
]

{ #category : #initialization }
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
	anchorElement dispatchEvent: (self editorClosedEventClass new
			 editorElement: editor;
			 yourself).

	anchorElement beforeEditorClosed: editor fromManager: self.
	self currentEditorEventHandlers do: [ :h |
		anchorElement removeEventHandler: h ].

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

	editor := anchorElement newEditorForManager: self.

	anchorElement beforeEditorOpened: editor fromManager: self.

	currentWindow root addChild: editor.
	anchorElement enqueueTask: (BlTaskAction new action: [
			 anchorElement dispatchEvent: (self editorOpenedEventClass new
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
	^ anchorElement addEventHandlerOn: self editorClosedEventClass do: aValuable
]

{ #category : #enumerating }
ToContentEditorManager >> whenEditorOpenedDo: aValuable [

	" aValuable takes the event as argument "
	^ anchorElement addEventHandlerOn: self editorOpenedEventClass do: aValuable
]
