Trait {
	#name : #TToBadgeableElement,
	#category : #'Toplo-Core'
}

{ #category : #'t - badgeable element' }
TToBadgeableElement >> addBadge: aBadge [

	self addEventHandler: (ToBadgeableEventHandler new
			 badge: aBadge;
			 yourself)
]

{ #category : #'t - badgeable element' }
TToBadgeableElement >> removeBadge: aBadge [

	self dispatchEvent: (ToBadgeRemovedEvent new
	badge: aBadge;
	yourself)
]
