Class {
	#name : #ToLookUpdaterTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-Look'
}

{ #category : #tests }
ToLookUpdaterTest >> testElementAdaption1 [

	| w updater installEvent |
	w := ToElement new.
	updater := ToLookUpdater new.
	updater when: ToInstallLookEvent do: [ :e | e background: Color white ].

	installEvent := ToInstallLookEvent new currentTarget: w..
	updater announceLookEvent: installEvent.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color white
]

{ #category : #tests }
ToLookUpdaterTest >> testPropertyAdaption1 [

	| w updater installEvent prop |

	w := ToElement new.
	prop := ToPropertyDefinition new.
	prop writer: [ :e :v | e background: v ].

	updater := ToLookUpdater new property: prop.
	updater when: ToInstallLookEvent value: Color white.

	installEvent := ToInstallLookEvent new currentTarget: w..
	updater announceLookEvent: installEvent.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color white
]

{ #category : #tests }
ToLookUpdaterTest >> testPropertyAdaption2 [

	| w updater installEvent prop hoveredEvent leavedEvent |

	w := ToElement new.
	prop := ToPropertyDefinition new.
	prop writer: [ :e :v | e background: v ].

	updater := ToLookUpdater new property: prop.
	updater when: ToInstallLookEvent value: Color white.
	updater when: ToHoveredLookEvent value: Color red.
	updater when: ToLeavedLookEvent value: Color gray.

	installEvent := ToInstallLookEvent new currentTarget: w.
	updater announceLookEvent: installEvent.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color white.
	
	hoveredEvent := ToHoveredLookEvent new currentTarget: w.
	updater announceLookEvent: hoveredEvent.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color red.
	
	leavedEvent := ToLeavedLookEvent new currentTarget: w.
	updater announceLookEvent: leavedEvent.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color gray
]

{ #category : #tests }
ToLookUpdaterTest >> testPropertyAdaption3 [

	| w updater installEvent prop hoveredEvent leavedEvent |

	w := ToElement new.
	prop := ToPropertyDefinition new.
	prop writer: [ :e :v | e background: v ].

	updater := ToLookUpdater new property: prop.
	updater when: ToInstallLookEvent value: [:e | Color white].
	updater when: ToHoveredLookEvent value: [:e | Color red].
	updater when: ToLeavedLookEvent value: [:e | Color gray].

	installEvent := ToInstallLookEvent new currentTarget: w.
	updater announceLookEvent: installEvent.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color white.
	
	hoveredEvent := ToHoveredLookEvent new currentTarget: w.
	updater announceLookEvent: hoveredEvent.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color red.
	
	leavedEvent := ToLeavedLookEvent new currentTarget: w.
	updater announceLookEvent: leavedEvent.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color gray
]
