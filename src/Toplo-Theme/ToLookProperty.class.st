Class {
	#name : #ToLookProperty,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'Toplo-Theme-LookUpdater'
}

{ #category : #accessing }
ToLookProperty >> name [

	^ name
]

{ #category : #accessing }
ToLookProperty >> name: anObject [

	name := anObject
]

{ #category : #operating }
ToLookProperty >> read: anObject [

	self subclassResponsibility 
]

{ #category : #operating }
ToLookProperty >> receiveLookEvent: aLookEvent from: aPropertySubscription [
	
	| target rawValue valueWriter |
	target := aLookEvent currentTarget.
	rawValue := (aPropertySubscription valueIn: target).
	valueWriter := aPropertySubscription valueWriter.
	valueWriter write: rawValue to: target
]

{ #category : #operating }
ToLookProperty >> setAsPropertyIn: aLookUpdater [

	" do nothing by default (auto property will)"
]

{ #category : #operating }
ToLookProperty >> write: anPropertyValue to: anObject [

	self subclassResponsibility 
]
