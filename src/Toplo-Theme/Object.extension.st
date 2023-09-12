Extension { #name : #Object }

{ #category : #'*Toplo-Theme' }
Object >> asElementUpdater [ 

	Error signal: 'Only valuable can be converted as an element adapter'
]

{ #category : #'*Toplo-Theme' }
Object >> asInstVarPropertyDef [

	^ ToInstVarPropertyDef new
		  name: self;
		  yourself
]

{ #category : #'*Toplo-Theme' }
Object >> asPropertyUpdaterFor: aPropertyDefinition [

	^ ToPropertyUpdater new
		  value: self;
		  property: aPropertyDefinition;
		  yourself
]

{ #category : #'*Toplo-Theme' }
Object >> asSlotPropertyDef [

	^ ToSlotPropertyDef new
		  name: self;
		  yourself
]
