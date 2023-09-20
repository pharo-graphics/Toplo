Extension { #name : 'ToElementProperty' }

{ #category : '*Toplo-Theme' }
ToElementProperty >> newWriterForValue: aBlockOrObject [

	^ ToPropertyWriter new
		  property: self;
		  value: aBlockOrObject;
		  yourself
]

{ #category : '*Toplo-Theme' }
ToElementProperty >> value: aBlockOrObject [

	^ self newWriterForValue: aBlockOrObject
]

{ #category : '*Toplo-Theme' }
ToElementProperty >> when: aLookEventClass write: aValuableOrObject animation: aPropertyAnimation [

	^ (self newWriterForValue: aValuableOrObject)
		  animation: aPropertyAnimation;
		  eventClass: aLookEventClass;
		  yourself
]

{ #category : '*Toplo-Theme' }
ToElementProperty >> write: aBlockOrObject [

	^ self newWriterForValue: aBlockOrObject
]
