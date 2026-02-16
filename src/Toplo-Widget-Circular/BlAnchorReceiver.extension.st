Extension { #name : #BlAnchorReceiver }

{ #category : #'*Toplo-Widget-Circular' }
BlAnchorReceiver >> centroidAnchor [

	^ ToAnnulusSectorCentroidAnchor new
		  receiver: self;
		  yourself
]
