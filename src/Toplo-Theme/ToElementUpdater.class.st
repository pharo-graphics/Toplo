Class {
	#name : #ToElementUpdater,
	#superclass : #ToValueUpdater,
	#instVars : [
		'valuable'
	],
	#category : #'Toplo-Theme-Look'
}

{ #category : #operating }
ToElementUpdater >> announceLookEvent: aLookEvent [

	self valuable value: aLookEvent currentTarget
]

{ #category : #converting }
ToElementUpdater >> asElementUpdater [

	^ self
]

{ #category : #accessing }
ToElementUpdater >> valuable [

	^ valuable
]

{ #category : #accessing }
ToElementUpdater >> valuable: aValuable [

	valuable := aValuable  
]
