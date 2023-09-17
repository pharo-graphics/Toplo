Extension { #name : #ToElementProperty }

{ #category : #'*Toplo-Theme' }
ToElementProperty >> newWriterForValue: aBlockOrObject [

	^ ToPropertyWriter new
		  property: self;
		  value: aBlockOrObject;
		  yourself
]

{ #category : #'*Toplo-Theme' }
ToElementProperty >> value: aBlockOrObject [

	^ self newWriterForValue: aBlockOrObject
]
