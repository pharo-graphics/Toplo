Trait {
	#name : #TToElementWithOverlayWindow,
	#category : 'Toplo-Core-Window'
}

{ #category : #'t - element with placeholder' }
TToElementWithOverlayWindow >> currentPlaceholder [

	^ self rawPlaceholderHandler ifNotNil: [ :h | h currentWindow ]
]

{ #category : #'t - element with placeholder' }
TToElementWithOverlayWindow >> hidePlaceholder [

	self rawPlaceholderHandler ifNotNil: [ :h | h currentWindow ifNotNil: [:w | w close ]]
]

{ #category : #'t - element with placeholder' }
TToElementWithOverlayWindow >> newPlaceholderEvent: anEvent [

	^ self rawPlaceholderHandler newWindowEvent: anEvent
]

{ #category : #'t - element with placeholder' }
TToElementWithOverlayWindow >> placeholderBuilder: aValuable [

	" aValuable take the context menu to build as first argument and the element with context menu as second aargument "
	
	aValuable 
		ifNil: [
			self removePlaceholderHandler.
			^ self ].
	self placeholderHandler builder: aValuable
]

{ #category : #'t - element with placeholder' }
TToElementWithOverlayWindow >> placeholderHandler [

	^ self userData at: #placeholderHandler ifAbsentPut: [
		  | handler |
		  handler := ToOverlayWindowHandler new.
		  handler
			  element: self;
			  yourself ]
]

{ #category : #'t - element with placeholder' }
TToElementWithOverlayWindow >> rawPlaceholderHandler [

	^ self userData at: #placeholderHandler ifAbsent: [ ]
]

{ #category : #'t - element with placeholder' }
TToElementWithOverlayWindow >> removePlaceholder [

	self removePlaceholderHandler
]

{ #category : #'t - element with placeholder' }
TToElementWithOverlayWindow >> removePlaceholderHandler [


	| handler |
	handler := self rawPlaceholderHandler.
	handler ifNil: [ ^ self ].
	handler hasWindow ifTrue: [ handler closeWindow ].
	handler element: nil.
	self userData removeKey: #placeholderHandler
]

{ #category : #'t - element with placeholder' }
TToElementWithOverlayWindow >> showPlaceholder [

	self rawPlaceholderHandler ifNotNil: [ :h |
		h currentWindow ifNotNil: [ ^ self ].
		h newWindowEvent: nil.
		h currentWindow popupEvent: nil ]
]
