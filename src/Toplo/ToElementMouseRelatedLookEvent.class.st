Class {
	#name : #ToElementMouseRelatedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-Look-Events'
}

{ #category : #sending }
ToElementMouseRelatedLookEvent >> sendTo: anObject [

	self target shouldChildrenHandleMouseEvents ifFalse: [
		self target allChildrenDepthFirstDo: [ :child |
			  child dispatchEvent: self clone ] ].
	super sendTo: anObject
]
