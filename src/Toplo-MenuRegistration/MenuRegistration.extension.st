Extension { #name : #MenuRegistration }

{ #category : #'*Toplo-MenuRegistration' }
MenuRegistration >> handOutItems [
	"we don't want to hold a reference to the items after they are hand out to the registration"

	| itemsCopy |
	itemsCopy := self itemList copy.
	self itemList removeAll.
	^ itemsCopy
]

{ #category : #'*Toplo-MenuRegistration' }
MenuRegistration >> initialize [
	super initialize.
	isGroup := false.
	itemList := OrderedCollection new
]

{ #category : #'*Toplo-MenuRegistration' }
MenuRegistration >> isGroup [

	^ isGroup
]

{ #category : #'*Toplo-MenuRegistration' }
MenuRegistration >> itemNames [

	^ itemList collect: [ :each | each name ]
]
