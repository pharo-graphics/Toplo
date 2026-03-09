Extension { #name : #BlAnchorReceiver }

{ #category : #'*Toplo-Widget-Circular' }
BlAnchorReceiver >> centroidAnchor [

	^ ToAnnulusSectorCentroidAnchor new
		  receiver: self;
		  yourself
]

{ #category : #'*Toplo-Widget-Circular' }
BlAnchorReceiver >> edgePointAnchor [

	^ ToAnnulusSectorEdgePointAnchor new
		  receiver: self;
		  yourself
]
