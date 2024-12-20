Trait {
	#name : #TToElementWithContentEditor,
	#category : #'Toplo-Core'
}

{ #category : #'t - element with content editor' }
TToElementWithContentEditor >> afterEditorClosingDo: aValuable [

	" aValuable takes the event as argument "
	^ self addEventHandlerOn: ToLabelEditorAfterClosingEvent do: aValuable
]

{ #category : #'t - element with content editor' }
TToElementWithContentEditor >> beforeEditorOpeningDo: aValuable [

	" aValuable takes the event as argument "
	^ self addEventHandlerOn: ToLabelEditorBeforeOpeningEvent do: aValuable
]

{ #category : #'t - element with content editor' }
TToElementWithContentEditor >> boundsForEditor [

	^ self bounds 
]

{ #category : #'t - element with content editor' }
TToElementWithContentEditor >> currentEditorClosingEventHandlers [

	^ Array streamContents: [ :stream |
		  self eventDispatcher handlersDo: [ :h |
			  ((h isKindOf: ToLabelEditorClosedEvent) or: [
				   h isKindOf: ToLabelEditorAfterClosingEvent ]) ifTrue: [
				  stream nextPut: h ] ] ]
]

{ #category : #'t - element with content editor' }
TToElementWithContentEditor >> currentEditorOpeningEventHandlers [

	^ Array streamContents: [ :stream |
		  self eventDispatcher handlersDo: [ :h |
			  ((h isKindOf: ToLabelEditorOpenedEvent) or: [
				   h isKindOf: ToLabelEditorBeforeOpeningEvent ]) ifTrue: [
				  stream nextPut: h ] ] ]
]

{ #category : #'t - element with content editor' }
TToElementWithContentEditor >> newEditor [
	" return the editor to use to edit the content of the element "
	^ self explicitRequirement
]

{ #category : #'t - element with content editor' }
TToElementWithContentEditor >> whenEditorClosedDo: aValuable [

	" aValuable takes the event as argument "
	^ self addEventHandlerOn: ToLabelEditorOpenedEvent do: aValuable
]

{ #category : #'t - element with content editor' }
TToElementWithContentEditor >> whenEditorOpenedDo: aValuable [

	" aValuable takes the event as argument "
	^ self addEventHandlerOn: ToLabelEditorOpenedEvent do: aValuable
]
