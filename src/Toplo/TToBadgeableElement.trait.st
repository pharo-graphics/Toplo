Trait {
	#name : #TToBadgeableElement,
	#category : #'Toplo-Core'
}

{ #category : #adding }
TToBadgeableElement >> addBadge: aBadge [

	self addEventHandler: (ToBadgeableEventHandler new
			 badge: aBadge;
			 yourself)
]

{ #category : #adding }
TToBadgeableElement >> removeBadge: aBadge [

	self dispatchEvent: (ToBadgeRemovedEvent new
	badge: aBadge;
	yourself)
]
