Trait {
	#name : 'TToElementWithOverlayWindow',
	#category : 'Toplo-Core-Window',
	#package : 'Toplo',
	#tag : 'Core-Window'
}

{ #category : 't - element with placeholder' }
TToElementWithOverlayWindow >> currentPlaceholder [

	^ self rawPlaceholderManager ifNotNil: [ :h | h currentWindow ]
]

{ #category : 't - element with placeholder' }
TToElementWithOverlayWindow >> hidePlaceholder [

	self rawPlaceholderManager ifNotNil: [ :h | h currentWindow ifNotNil: [:w | w close ]]
]

{ #category : 't - element with placeholder' }
TToElementWithOverlayWindow >> newPlaceholderEvent: anEvent [

	^ self rawPlaceholderManager newWindowEvent: anEvent
]

{ #category : 't - element with placeholder' }
TToElementWithOverlayWindow >> placeholderBuilder: aValuable [

	" aValuable take the context menu to build as first argument and the element with context menu as second aargument "
	
	aValuable 
		ifNil: [
			self removePlaceholderManager.
			^ self ].
	self placeholderManager builder: aValuable
]

{ #category : 't - element with placeholder' }
TToElementWithOverlayWindow >> placeholderManager [

	^ self userData at: #placeholderManager ifAbsentPut: [
		  | handler |
		  handler := ToOverlayWindowManager new.
		  handler
			  element: self;
			  yourself ]
]

{ #category : 't - element with placeholder' }
TToElementWithOverlayWindow >> rawPlaceholderManager [

	^ self userData at: #placeholderManager ifAbsent: [ ]
]

{ #category : 't - element with placeholder' }
TToElementWithOverlayWindow >> removePlaceholder [

	self removePlaceholderManager
]

{ #category : 't - element with placeholder' }
TToElementWithOverlayWindow >> removePlaceholderManager [


	| handler |
	handler := self rawPlaceholderManager.
	handler ifNil: [ ^ self ].
	handler hasWindow ifTrue: [ handler closeWindow ].
	handler element: nil.
	self userData removeKey: #placeholderManager
]

{ #category : 't - element with placeholder' }
TToElementWithOverlayWindow >> showPlaceholder [

	self rawPlaceholderManager ifNotNil: [ :h |
		h currentWindow ifNotNil: [ ^ self ].
		h newWindowEvent: nil.
		h currentWindow popupEvent: nil ]
]
