Class {
	#name : #ToCircularMenuList,
	#superclass : #ToMenuItemListElement,
	#traits : 'TToAnnulusSectorLayoutUser + TToAnnulusCircularLayoutUser + TToCircularMenuList',
	#classTraits : 'TToAnnulusSectorLayoutUser classTrait + TToAnnulusCircularLayoutUser classTrait + TToCircularMenuList classTrait',
	#category : #'Toplo-Widget-Circular-Menu'
}

{ #category : #configuration }
ToCircularMenuList >> applyConfiguration [

	super applyConfiguration.
	self nodeContainersDo: [ :container |
			| item radGap |
			item := container node item.
			radGap := item constraints annulus sectorRadialGap ifNil: [
				          self defaultSectorRadialGap ].
			container constraints annulus sectorRadialGap: radGap.
			container radialGap: radGap ]
]

{ #category : #initialization }
ToCircularMenuList >> defaultInnerElementClass [ 

	^ ToCircularMenuInnerElement 
]

{ #category : #initialization }
ToCircularMenuList >> defaultNodeManager [

	^ super defaultNodeManager
		  nodeContainerFactory: [ ToCircularMenuNodeContainer new ];
		  nodeFactory: [ :holder | ToCircularMenuNode new ];
		  yourself
]

{ #category : #initialization }
ToCircularMenuList >> initialize [

	super initialize.
	self geometry: BlCircleGeometry new.
	self secondarySelectionOption elementFactory: [
		ToCircularMenuListSecondarySelectionElement new ].
	self matchParent
]

{ #category : #testing }
ToCircularMenuList >> isOutsideEvent: anEvent [

	^ self nodeContainers allSatisfy: [ :container |
		  container isOutsideEvent: anEvent ]
]

{ #category : #'t - annulus sector layout user' }
ToCircularMenuList >> stateHolder [

	^ self innerElement 
]
