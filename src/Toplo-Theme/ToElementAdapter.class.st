Class {
	#name : #ToElementAdapter,
	#superclass : #ToLookAdapter,
	#instVars : [
		'valuable'
	],
	#category : #'Toplo-Theme-Look'
}

{ #category : #operating }
ToElementAdapter >> announceLookEvent: aLookEvent [

	self valuable value: aLookEvent currentTarget
]

{ #category : #converting }
ToElementAdapter >> asElementAdapter [

	^ self
]

{ #category : #accessing }
ToElementAdapter >> valuable [

	^ valuable
]

{ #category : #accessing }
ToElementAdapter >> valuable: aValuable [

	valuable := aValuable  
]
