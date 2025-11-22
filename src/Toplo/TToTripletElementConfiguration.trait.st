Trait {
	#name : #TToTripletElementConfiguration,
	#category : #'Toplo-Core'
}

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> applyTripletElementConfigurationOn: anElement [

	self configureStartElementIn: anElement.
	self configureEndElementIn: anElement.
	self applyTripletContainerConfigurationOn: anElement
]

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> configureEndElementIn: anElement [

	anElement endElement ifNil: [ ^ self ].
	anElement isHorizontal
		ifTrue: [
			anElement endElement constraints frame horizontal alignRight.
			anElement endElement constraints linear horizontal alignRight ]
		ifFalse: [
			anElement endElement constraints frame vertical alignBottom.
			anElement endElement constraints linear vertical alignBottom ]
]

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> configureStartElementIn: anElement [

	anElement startElement ifNil: [ ^ self ].
	anElement isHorizontal
		ifTrue: [
			anElement startElement constraints frame horizontal alignLeft.
			anElement startElement constraints linear horizontal alignLeft ]
		ifFalse: [
			anElement startElement constraints frame vertical alignBottom.
			anElement startElement constraints linear vertical alignBottom ]
]

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> initializeAsTripletElementConfiguration [


]
