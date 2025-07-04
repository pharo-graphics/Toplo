Class {
	#name : #ToCheckableCheckEvent,
	#superclass : #BlEvent,
	#instVars : [
		'checked'
	],
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #'instance creation' }
ToCheckableCheckEvent class >> checked: aBoolean [

	^ self new
		  checked: aBoolean;
		  yourself
]

{ #category : #accessing }
ToCheckableCheckEvent >> checked [

	^ checked
]

{ #category : #accessing }
ToCheckableCheckEvent >> checked: aBoolean [

	checked := aBoolean 
]

{ #category : #accessing }
ToCheckableCheckEvent >> current [

	self deprecated: '#checked instead' transformWith: '`@rcvr current' -> '`@rcvr checked'.
	^ self checked
]

{ #category : #accessing }
ToCheckableCheckEvent >> current: aBoolean [

	self deprecated: '#checked: instead' transformWith: '`@rcvr current: `@arg' -> '`@rcvr checked: `@arg'.
	self checked: aBoolean
]

{ #category : #sending }
ToCheckableCheckEvent >> sendTo: anObject [

	anObject checkableCheckEvent: self
]
