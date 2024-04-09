Extension { #name : #ToLabeledIcon }

{ #category : #'*Toplo-Theme-Bee' }
ToLabeledIcon >> defaultBeeStyleStamps [

	^ #( #'labeled-icon' )
]

{ #category : #'*Toplo-Theme-Bee' }
ToLabeledIcon >> installBeeStyle [

	super installBeeStyle.

	self startFiller addStamp: #'labeled-icon-filler'.
	self icon ifNotNil: [ :ic | ic addStamp: #icon ].
	self label ifNotNil: [ :la | la addStamp: #label ].

	self isStartToEnd
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

	self isStartFlexible
		ifTrue: [
			self removeStamp: #'exact-interspace'.
			self addStamp: #'start-flexible' ]
		ifFalse: [
			self addStamp: #'exact-interspace'.
			self removeStamp: #'start-flexible' ]
]
