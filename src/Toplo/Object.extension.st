Extension { #name : 'Object' }

{ #category : '*Toplo' }
Object class >> asElementSelector [

	^ ToTypeSelector new type: self
]
