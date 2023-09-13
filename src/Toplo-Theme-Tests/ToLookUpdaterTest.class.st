Class {
	#name : #ToLookUpdaterTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-LookUpdater'
}

{ #category : #tests }
ToLookUpdaterTest >> monospacedFontFamilyName [
		
	^ 'Source Code Pro'
]

{ #category : #tests }
ToLookUpdaterTest >> testLookUpdaterFailsWithPseudoPropertyWithWrongWriter [
	" a ToElement DNU #fontName: "

	| w updater installEvent prop |
	w := ToElement new.
	prop := ToPseudoProperty new name: #'font-name'.
	prop writer: [ :e :v | e fontName: v ].

	updater := ToLookUpdater new property: prop.
	updater when: ToInstallLookEvent value: Color white.

	installEvent := ToInstallLookEvent new currentTarget: w.
	self should: [ updater receiveLookEvent: installEvent ] raise: MessageNotUnderstood
]

{ #category : #tests }
ToLookUpdaterTest >> testLookUpdaterNeedPropertyForValueUpdating [

	| w updater  |

	w := ToElement new.

	updater := ToLookUpdater new property: nil.
	updater when: ToInstallLookEvent do: [ :e | e background: Color white ].
	self should: [ updater when: ToInstallLookEvent value: Color white ] raise: Error
]

{ #category : #tests }
ToLookUpdaterTest >> testLookUpdaterWithPseudoProperty [

	| w updater installEvent prop |

	w := ToElement new.
	prop := ToPseudoProperty new.
	prop writer: [ :e :v | e background: v ].

	updater := ToLookUpdater new property: prop.
	updater when: ToInstallLookEvent value: Color white.

	installEvent := ToInstallLookEvent new currentTarget: w..
	updater receiveLookEvent: installEvent.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color white
]

{ #category : #tests }
ToLookUpdaterTest >> testLookUpdaterWithPseudoPropertyFor3StatesWithRawValue [

	| w updater installEvent prop hoveredEvent leavedEvent |

	w := ToElement new.
	prop := ToPseudoProperty new.
	prop writer: [ :e :v | e background: v ].

	updater := ToLookUpdater new property: prop.
	updater when: ToInstallLookEvent value: Color white.
	updater when: ToHoveredLookEvent value: Color red.
	updater when: ToLeavedLookEvent value: Color gray.

	installEvent := ToInstallLookEvent new currentTarget: w.
	updater receiveLookEvent: installEvent.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color white.
	
	hoveredEvent := ToHoveredLookEvent new currentTarget: w.
	updater receiveLookEvent: hoveredEvent.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color red.
	
	leavedEvent := ToLeavedLookEvent new currentTarget: w.
	updater receiveLookEvent: leavedEvent.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color gray
]

{ #category : #tests }
ToLookUpdaterTest >> testLookUpdaterWithPseudoPropertyFor3StatesWithValuable [

	| w updater installEvent prop hoveredEvent leavedEvent |

	w := ToElement new.
	prop := ToPseudoProperty new.
	prop writer: [ :e :v | e background: v ].

	updater := ToLookUpdater new property: prop.
	updater when: ToInstallLookEvent value: [:e | Color white].
	updater when: ToHoveredLookEvent value: [:e | Color red].
	updater when: ToLeavedLookEvent value: [:e | Color gray].

	installEvent := ToInstallLookEvent new currentTarget: w.
	updater receiveLookEvent: installEvent.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color white.
	
	hoveredEvent := ToHoveredLookEvent new currentTarget: w.
	updater receiveLookEvent: hoveredEvent.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color red.
	
	leavedEvent := ToLeavedLookEvent new currentTarget: w.
	updater receiveLookEvent: leavedEvent.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color gray
]

{ #category : #tests }
ToLookUpdaterTest >> testLookUpdaterWithoutProperty [

	| w updater installEvent |
	w := ToElement new.
	updater := ToLookUpdater new.
	updater when: ToInstallLookEvent do: [ :e | e background: Color white ].

	installEvent := ToInstallLookEvent new currentTarget: w.
	updater receiveLookEvent: installEvent.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color white
]
