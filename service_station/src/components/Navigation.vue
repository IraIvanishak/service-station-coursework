<template>
    <div class="navigation">

        <router-link to="/stations" class="nav-link"><i class="fas fa-gas-pump"></i> Stations</router-link>
        <router-link to="/supply" class="nav-link"><i class="fas fa-box-open"></i> Supplies</router-link>
        <router-link to="/repairs" class="nav-link"><i class="fas fa-tools"></i> Repairs</router-link>
        <router-link to="/client" class="nav-link"><i class="fas fa-users"></i> Clients</router-link>
        <router-link to="/Employee" class="nav-link"><i class="fas fa-user-tie"></i> Employees</router-link>
        <div @click="toggleSubMenu" class="nav-link"> <i class="fas fa-chart-line"></i> Analytics 
            <div v-if="showSubMenu" class="sub-menu">
                <router-link to="/dashboard" class="nav-link"><i class="fas fa-tachometer-alt"></i> Dashboard</router-link>
                <router-link to="/meta" class="nav-link"><i class="fas fa-database"></i> Data Load</router-link>
                <router-link to="/cube/service" class="nav-link"><i class="fas fa-cogs"></i> Service Cube</router-link>
                <router-link to="/cube/supply" class="nav-link"><i class="fas fa-truck-loading"></i> Supply Cube</router-link>
            </div>
        </div>
    </div>
</template>


<script>
export default {
    name: 'Navigation',
    data() {
        return {
            showSubMenu: false,
        };
    },
    methods: {
        toggleSubMenu() {
            this.showSubMenu = !this.showSubMenu;
        }
    }
}
</script>


<style scoped>
.navigation {
    border-radius: 5px;
    display: flex;
    flex-direction: column; /* Set the flex direction to column */
    background-color: #771150;
    padding: 10px;
}

.nav-link {
    font-size: 20px;
    text-decoration: none;
    color: #ffffff;
    margin-bottom: 10px; /* Adjust the margin to create vertical spacing */
    cursor: pointer;
}

.nav-link:hover {
    color: #ecd7d7;
}

.sub-menu {
    display: flex;
    flex-direction: column;
    padding-left: 20px;
}

.sub-menu .nav-link {
    font-size: 16px;
    margin-top: 5px;
}
i {
    margin-right: 10px;
    margin-left: 10px;
    font-size: small;
}
</style>