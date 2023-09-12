Extension { #name : #Object }

{ #category : #'*Toplo-Theme' }
Object >> asElementSubscription [ 

	Error signal: 'Only valuable can be converted as an element adapter'
]

{ #category : #'*Toplo-Theme' }
Object >> asInstVarPropertyDef [

	^ ToInstVarProperty new
		  name: self;
		  yourself
]

{ #category : #'*Toplo-Theme' }
Object >> asPropertySubscriptionFor: aPropertyDefinition [

	^ ToPropertySubscription new
		  value: self;
		  property: aPropertyDefinition;
		  yourself
]

{ #category : #'*Toplo-Theme' }
Object >> asSlotPropertyDef [

	^ ToSlotProperty new
		  name: self;
		  yourself
]
