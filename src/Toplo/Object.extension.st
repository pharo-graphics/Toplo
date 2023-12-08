Extension { #name : 'Object' }

{ #category : '*Toplo' }
Object class >> asTypeSelector [

	^ ToTypeSelector new type: self
]
