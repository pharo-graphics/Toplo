Extension { #name : #BlAnchorReceiver }

{ #category : #'*Toplo-Widget-List' }
BlAnchorReceiver >> centroidAnchor [

	^ ToElementCentroidAnchor new
		  receiver: self;
		  yourself
]
