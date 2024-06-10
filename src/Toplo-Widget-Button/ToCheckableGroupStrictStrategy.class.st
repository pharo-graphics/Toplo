Class {
	#name : #ToCheckableGroupStrictStrategy,
	#superclass : #ToCheckableGroupStrategy,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #testing }
ToCheckableGroupStrictStrategy >> allowUnchecking [

	^ false
]

{ #category : #testing }
ToCheckableGroupStrictStrategy >> checkChangePreNotification: aPreCheckableChangedEvent in: aGroup [
	" do not allow to uncheck a button by checking it "

	| target checked |
	target := aPreCheckableChangedEvent currentTarget.
	checked := aPreCheckableChangedEvent checked.
	(checked not and: [ target checked ]) ifTrue: [
		aPreCheckableChangedEvent deny.
		^ self ].
	" ok, the button is unchecked -> uncheck others then check it"
	aGroup uncheckAllExcept: target
]

{ #category : #notifications }
ToCheckableGroupStrictStrategy >> onButtonAdded: aCheckable in: aGroup [

	aCheckable isChecked ifTrue: [
		(aGroup buttons select: [ :b | b ~= aCheckable and: [ b checked ] ])
			do: [ :b | b privateChecked: false ] ].
	super onButtonAdded: aCheckable in: aGroup
]

{ #category : #notifications }
ToCheckableGroupStrictStrategy >> register: aCheckable in: aGroup [

	aCheckable isChecked ifTrue: [
		(aGroup registeredCheckables select: [ :b |
			 b ~= aCheckable and: [ b checked ] ]) do: [ :b |
			b privateChecked: false ] ].
	super register: aCheckable in: aGroup
]
