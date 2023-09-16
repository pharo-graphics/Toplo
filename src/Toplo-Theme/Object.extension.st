Extension { #name : #Object }

{ #category : #'*Toplo-Theme' }
Object >> asInstVarPropertyDef [

	^ ToFeatureProperty new
		  name: self;
		  yourself
]

{ #category : #'*Toplo-Theme' }
Object >> asSlotPropertyDef [

	^ ToSlotProperty new
		  name: self;
		  yourself
]
