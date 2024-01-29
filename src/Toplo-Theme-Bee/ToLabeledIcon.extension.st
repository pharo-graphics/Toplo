Extension { #name : #ToLabeledIcon }

{ #category : #'*Toplo-Theme-Bee' }
ToLabeledIcon >> defaultBeeStyleStamps [

	^ #( #'labeled-icon' )
]

{ #category : #'*Toplo-Theme-Bee' }
ToLabeledIcon >> installBeeStyle [

	super installBeeStyle.

	self filler addStamp: #'labeled-icon-filler'.
	self icon ifNotNil: [ :ic | ic addStamp: #icon ].
	self label ifNotNil: [ :la | la addStamp: #label ].

	self isIconFirst
		ifTrue: [
			self addStamp: #'icon-first'.
			self removeStamp: #'label-first' ]
		ifFalse: [
			self addStamp: #'label-first'.
			self removeStamp: #'icon-first' ].

	self isHorizontal
		ifTrue: [
			self addStamp: #horizontal.
			self removeStamp: #vertical ]
		ifFalse: [
			self addStamp: #vertical.
			self removeStamp: #horizontal ].

	self isFlexible
		ifTrue: [
			self removeStamp: #'exact-interspace'.
			self addStamp: #flexible ]
		ifFalse: [
			self addStamp: #'exact-interspace'.
			self removeStamp: #flexible ]
]
