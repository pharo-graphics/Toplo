Extension { #name : #ToLabeledIcon }

{ #category : #'*Toplo-Theme-Bee' }
ToLabeledIcon >> defaultBeeStyleStamps [

	^ #( #'labeled-icon' )
]

{ #category : #'*Toplo-Theme-Bee' }
ToLabeledIcon >> initializeBeeStyle [

	super initializeBeeStyle.
	self withStamp: #'labeled-icon'.
	self filler withStamp: #'labeled-icon-filler'.
	self filler id: #filler.
	self iconHolder id: #'icon-holder'.
	self icon ifNotNil: [ :ic | ic withStamp: #icon ].
	self isIconFirst
		ifTrue: [
			self withStamp: #'icon-first'.
			self withoutStamp: #'label-first' ]
		ifFalse: [
			self withStamp: #'label-first'.
			self withoutStamp: #'icon-first' ].
	self isHorizontal
		ifTrue: [
			self withStamp: #horizontal.
			self withoutStamp: #vertical ]
		ifFalse: [
			self withStamp: #vertical.
			self withoutStamp: #horizontal ].
	self label ifNotNil: [ :la | la withStamp: #label ].
	self isFlexible
		ifTrue: [
			self withoutStamp: #'exact-interspace'.
			self withStamp: #flexible ]
		ifFalse: [
			self withStamp: #'exact-interspace'.
			self withoutStamp: #flexible ]
]
