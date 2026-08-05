enum AssignedTicketFilter {
  all,
  
  // Status
  statusAssigned,
  statusAccepted,
  statusInProgress,
  statusPaused,
  statusEscalated,
  statusResolved,
  statusClosed,
  
  // Priority
  priorityCritical,
  priorityHigh,
  priorityMedium,
  priorityLow,
  
  // Category
  categoryElectrical,
  categoryPlumbing,
  categoryHVAC,
  categoryCleaning,
  categoryLighting,
  categoryEscalator,
  categoryFireSafety,
  categoryGeneral,
  
  // Floor
  floorBasement,
  floorGround,
  floorFirst,
  floorSecond,
  
  // Time
  timeToday,
  timeYesterday,
  timeLast7Days,
  timeLast30Days;

  String toDisplayString() {
    switch (this) {
      case AssignedTicketFilter.all:
        return 'All Tickets';
      
      // Status
      case AssignedTicketFilter.statusAssigned: return 'Assigned';
      case AssignedTicketFilter.statusAccepted: return 'Accepted';
      case AssignedTicketFilter.statusInProgress: return 'In Progress';
      case AssignedTicketFilter.statusPaused: return 'Paused';
      case AssignedTicketFilter.statusEscalated: return 'Escalated';
      case AssignedTicketFilter.statusResolved: return 'Resolved';
      case AssignedTicketFilter.statusClosed: return 'Closed';
      
      // Priority
      case AssignedTicketFilter.priorityCritical: return 'Critical';
      case AssignedTicketFilter.priorityHigh: return 'High';
      case AssignedTicketFilter.priorityMedium: return 'Medium';
      case AssignedTicketFilter.priorityLow: return 'Low';
      
      // Category
      case AssignedTicketFilter.categoryElectrical: return 'Electrical';
      case AssignedTicketFilter.categoryPlumbing: return 'Plumbing';
      case AssignedTicketFilter.categoryHVAC: return 'HVAC';
      case AssignedTicketFilter.categoryCleaning: return 'Cleaning';
      case AssignedTicketFilter.categoryLighting: return 'Lighting';
      case AssignedTicketFilter.categoryEscalator: return 'Escalator';
      case AssignedTicketFilter.categoryFireSafety: return 'Fire Safety';
      case AssignedTicketFilter.categoryGeneral: return 'General Maintenance';
      
      // Floor
      case AssignedTicketFilter.floorBasement: return 'Basement';
      case AssignedTicketFilter.floorGround: return 'Ground';
      case AssignedTicketFilter.floorFirst: return 'First';
      case AssignedTicketFilter.floorSecond: return 'Second';
      
      // Time
      case AssignedTicketFilter.timeToday: return 'Today';
      case AssignedTicketFilter.timeYesterday: return 'Yesterday';
      case AssignedTicketFilter.timeLast7Days: return 'Last 7 Days';
      case AssignedTicketFilter.timeLast30Days: return 'Last 30 Days';
    }
  }
}
