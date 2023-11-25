Extension { #name : 'ToLabeledIcon' }

{ #category : '*Toplo-Theme-Bee' }
ToLabeledIcon >> defaultBeeStyleStamps [

	^ #( #'labeled-icon' )
]

{ #category : '*Toplo-Theme-Bee' }
ToLabeledIcon >> installBeeStyle [

	super installBeeStyle.

	"self filler id: #filler.	
	self filler withStamp: #'labeled-icon-filler'."
	
	"self iconHolder id: #'icon-holder'.
	self labelHolder id: #'label-holder'."
	
	"self icon ifNotNil: [ :ic | ic withStamp: #icon ].
	self label ifNotNil: [ :la | la withStamp: #label ]."
	
	self isIconFirst
		ifTrue: [
			self addStamp: #'icon-first'.
			self resmoveStamp: #'label-first' ]
		ifFalse: [
			self addStamp: #'label-first'.
			self resmoveStamp: #'icon-first' ].
		
	self isHorizontal
		ifTrue: [
			self addStamp: #horizontal.
			self resmoveStamp: #vertical ]
		ifFalse: [
			self addStamp: #vertical.
			self resmoveStamp: #horizontal ].

	self isFlexible
		ifTrue: [
			self resmoveStamp: #'exact-interspace'.
			self addStamp: #flexible ]
		ifFalse: [
			self addStamp: #'exact-interspace'.
			self resmoveStamp: #flexible ]
]
